output "cluster_id" {
  value       = yandex_mdb_mysql_cluster.mysql_cluster.id
  description = "The unique identifier of the created MySQL cluster"
}