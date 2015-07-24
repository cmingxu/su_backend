require 'sketchup'
require 'fileutils'
require 'logger'

# global varible set app in debuging mode or not
SKETCHUP_CONSOLE.show

$PLATFORM = (RUBY_PLATFORM =~ /darwin/ ? "MACOS" : "WINDOWS")

# directory we working on 
$ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), "su_building"))

# add ruby file path into loading pathes
$LOAD_PATH.push(File.join($ROOT_PATH,  "ruby"))

$SKP_PATH = File.expand_path(File.join($ROOT_PATH , "skps"))
FileUtils.mkdir_p($SKP_PATH) if !File.exists?($SKP_PATH)
FileUtils.chmod(0777, $SKP_PATH)

# load required rb files
require 'ui'

## Logger
$TMP_FILE_PATH = $ROOT_PATH + "/tmp"
FileUtils.mkdir_p($TMP_FILE_PATH) if !File.exists?($TMP_FILE_PATH)
FileUtils.chmod(0777, $TMP_FILE_PATH)
# setup logger for logging purpose
$logger = Logger.new File.join($TMP_FILE_PATH,  "logger.log")
$logger.debug "Initializing APP"


UI.menu("Plugins").add_item("Show ") do
  BuildingUI.new.show
end

