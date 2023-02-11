data "archive_file" "src" {
  type        = "zip"
  source_dir = "${var.root_app_path}/app/src/"
  output_path = "${var.root_app_path}/app/artifacts/src_code.zip"
}