variable "BUILD_VERSION" {
  default = "dev"
}

variable "PYTHON_VERSION" {
  default = "3.13.5"
}

variable "PYTHON_BASE_VARIANT" {
  default = "slim-bookworm"
}

variable "PYTHON_BASE_SHA" {
  default = "f2fdaec50160418e0c2867ba3e254755edd067171725886d5d303fd7057bbf81"
}

group "default" {
  targets = ["python"]
}

target "python" {
  context = "docker/python"
  args = {
    PYTHON_TAG_SHA = "${PYTHON_VERSION}-${PYTHON_BASE_VARIANT}@sha256:${PYTHON_BASE_SHA}"
  }
  tags = [
    "ghcr.io/powerhome/cdk8s-cmp-python:${BUILD_VERSION}-${PYTHON_VERSION}"
  ]
}
