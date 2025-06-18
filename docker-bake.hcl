group "default" {
  targets = ["python"]
}

variable "PYTHON_TAG" {
  default = "3.13.5-slim-bookworm"
}

variable "PYTHON_SHA" {
  default = "f2fdaec50160418e0c2867ba3e254755edd067171725886d5d303fd7057bbf81"
}

target "python" {
  context = "docker/python"
  args = {
    PYTHON_TAG_SHA = "${PYTHON_TAG}@sha256:${PYTHON_SHA}"
  }
  tags = [
    "ghcr.io/powerhome/cdk8s-cmp-python:${PYTHON_TAG}"
  ]
}
