/**
 * # Raspberry Pi Image Example
 *
 * Source Usage: [root](../../)
 *
 * See also: https://www.talos.dev/v1.9/talos-guides/install/single-board-computers/rpi_generic/
 */

module "talos_image_factory" {
  source = "../../"

  # Just pulling latest stable for this example
  talos_version_spec = { pattern = ".*" }

  # Schematic Configuration
  overlay = {
    name = "rpi_generic"
    # https://www.raspberrypi.com/documentation/computers/config_txt.html
    options = {
      configTxtAppend = "display_auto_detect=1"
    }
  }

  # URL Configuration
  architecture = "arm64"
  sbc          = "rpi_generic"
}
