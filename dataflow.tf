resource "google_dataflow_job" "big_data_job" {
    name = "dataflow-job"
    project = "aerial-passage-248314"
    template_gcs_path = "gs://my-bucket/templates/template_file"
    temp_gcs_location = "gs://my-bucket/tmp_dir"
    parameters = {
        foo = "bar"
        baz = "qux"
    }
}