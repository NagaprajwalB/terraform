resource "aws_db_instance" "My-RDS" {
    allocated_storage = 10
    db_name = "upesdb"
    engine = "mysql"
    engine_version = "8.0.41"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "Hitesh111"
    # parameter_group_name = "default.mysql5.7"
    # skip_final_snapshot = true
}
