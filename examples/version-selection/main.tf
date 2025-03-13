/**
 * # Version Selection Example
 *
 * Source Usage: [root](../../)
 *
 * Provided examples show the recommended approach of specifying
 * an exact version number, as well as using pattern matching
 * and the `stable_only` flag to control what versions are selected.
 */

# Recommended: Select a specific version of Talos to use.
module "lock_full_version" {
  source = "../../"

  talos_version_spec = {
    number = "v1.9.4"
  }
  platform = "metal"
}

# Use a regex to lock the major.minor version to "1.8"
# but allow any patch version.
module "latest_stable_patch_version" {
  source = "../../"

  talos_version_spec = {
    pattern = "v1\\.8\\..*"
  }
  platform = "metal"
}

# Use a regex pattern to select the latest version,
# optionally allowing un-stable releases as well.
module "latest_unstable_version" {
  source = "../../"

  talos_version_spec = {
    pattern     = ".*"
    stable_only = false
  }
  platform = "metal"
}
