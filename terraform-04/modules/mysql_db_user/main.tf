resource "yandex_mdb_mysql_database" "mysql_database" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "mysql_user" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.user_password

  permission {
    database_name = yandex_mdb_mysql_database.mysql_database.name
    roles         = ["ALL"]
  }
}