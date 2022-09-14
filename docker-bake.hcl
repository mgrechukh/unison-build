group "default" {
  targets = ["amd64", "arm64", "armhf"]
}

target "amd64" {
  output = ["release"]
  platforms = ["amd64"]
  target = "guibinaries"
}

target "arm64" {
  output = ["release"]
  platforms = ["arm64"]
  target = "binaries"
}

target "armhf" {
  output = ["release"]
  platforms = ["armhf"]
  target = "binaries"
}
