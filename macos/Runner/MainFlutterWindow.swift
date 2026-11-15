import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    // The board and controls are laid out for phone and tablet shapes; keep
    // the window large enough for the landscape layout to breathe.
    self.contentMinSize = NSSize(width: 720, height: 620)
    self.setContentSize(NSSize(width: 1180, height: 820))
    self.center()
    // Remembers the user's own size and position after the first launch.
    self.setFrameAutosaveName("ClassicReversiMainWindow")

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
