group "default" {
  targets = ["amd64", "arm64", "armhf"]
}

target "amd64" {
  output = ["bin-amd64"]
  platforms = ["amd64"]
  target = "guibinaries"
}

target "arm64" {
  output = ["bin-arm64"]
  platforms = ["arm64"]
  target = "binaries"
}

target "armhf" {
  output = ["bin-armhf"]
  platforms = ["armhf"]
  target = "binaries"
}
