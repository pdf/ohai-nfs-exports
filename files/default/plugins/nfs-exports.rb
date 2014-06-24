#
# Author:: Peter Fern (<ruby@0xc0dedbad.com>)
# License:: MIT License
#
# Licensed under the MIT License, Copyright (c) 2013 Peter Fern,
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://opensource.org/licenses/MIT
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

Ohai.plugin(:NfsExports) do
  provides 'nfs/exports'

  collect_data(:linux) do
    nfs Mash.new
    nfs[:exports] = Mash.new

    exportfs = Mixlib::ShellOut.new('exportfs -v')
    exportfs.run_command
    unless exportfs.error?
      export = nil

      exportfs.stdout.each_line do |line|
        if line =~ /^\//
          export = line.strip
          nfs[:exports][export] = Mash.new
        else
          client_match = /^\s+([^\s\(]+)\((.*)\)/.match(line)
          nfs[:exports][export][client_match[1]] = client_match[2].split(',')
        end
      end
    end
  end
end
