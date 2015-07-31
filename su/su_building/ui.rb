require 'action_callback'

class BuildingUI
  WIDTH = 400
  HEIGHT = 600
  LEFT = 100
  TOP = 100

  attr_accessor :my_dialog
  attr_accessor :action_callbacks

  def initialize
    @my_dialog = UI::WebDialog.new("构建中国", true, "", WIDTH, HEIGHT, LEFT, TOP, true)
    @action_callbacks = []
    @my_dialog.url = "http://jghtwl.com:8081/plugin"
    @my_dialog.allow_actions_from_host "http://jghtwl.com"

    @my_dialog.min_height = @my_dialog.max_height = HEIGHT
    @my_dialog.min_width = @my_dialog.max_width = WIDTH
    ActionCallback.register_callbacks(@my_dialog)
  end


  def show
    @my_dialog.show
  end

end
