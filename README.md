# Домашнее задание к занятию «Продвинутые методы работы с Terraform» - Розаев А.Ю.

### Цели задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.

### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код взят из директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания - прерываемые, для экономии средств.

------

### Задание 1

1. Из [демонстрации к лекции](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) взят готовый код для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам (marketing и analytics) для обозначения принадлежности использованы labels.  В файле cloud-init.yml использована переменная для ssh-ключа вместо хардкода. Ssh-ключ передан в функцию template_file в блоке vars ={},
[**пример**](https://oneuptime.com/blog/post/2026-03-02-how-to-use-cloud-init-with-terraform-for-ubuntu-provisioning/view).
3. В файл cloud-init.yml добавлена установка nginx.
4. Ниже приложены 
- скриншоты подключения к консоли и вывод команды ```sudo nginx -t```
- скриншот консоли ВМ yandex cloud с их метками
- скриншот terraform console с содержимым модуля

![1_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_1.png)

![1_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_2.png)

![1_3](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_3.png)

![1_4](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_4.png)

![1_5](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_5.png)

![1_6](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_6.png)

![1_7](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_7.png)

![1_8](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_8.png)

![1_9](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_9.png)

![1_10](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_10.png)

![1_11](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_1_11.png)

---

### Задание 2

1. Написан локальный модуль vpc, который создает 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля.
Вызов модуля
```
module "vpc_dev" {
  source           = "./modules/vpc"
  env_name         = var.env_name
  zone             = var.default_zone
  v4_cidr_blocks   = "10.0.1.0/24"
}
```

2. В модуль переданы переменные с названием сети, zone и v4_cidr_blocks.

3. Модуль возвращает в root module с помощью output информацию о yandex_vpc_subnet. 
Скриншот информации из terraform console о модуле:

![2_3_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_2_3_1.png)

![2_3_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_2_3_2.png)

4. Ресурсы yandex_vpc_network и yandex_vpc_subnet заменены созданным модулем.
5. Сгенерирована документация к модулю с помощью terraform-docs.

![2_5](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_2_5.png)

---

### Задание 3
1. Выведен список ресурсов в стейте.
```
terraform state list
```
2. Полностью удален из стейта модуль vpc.
```
terraform state rm module.vpc_dev
```
3. Полностью удален из стейта модуль vm.
```
terraform state rm module.marketing_vm
terraform state rm module.analytics_vm
```
4. Всё импортировано обратно. 
```
terraform import module.vpc_dev.yandex_vpc_network.vpc_dev enp9da6l29dab0p0vs1v
terraform import module.vpc_dev.yandex_vpc_subnet.vpc_dev fl8ockr2ph6s02lg6e6k
terraform import 'module.marketing_vm.yandex_compute_instance.vm[0]' fv45t7pr6vn3083m62bj
terraform import 'module.analytics_vm.yandex_compute_instance.vm[0]' fv4suv879g14lhe9ss25
```
Проверен terraform plan. Значимых изменений нет.

![3_4_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_3_4_1.png)

![3_4_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_3_4_2.png)

![3_4_3](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_3_4_3.png)

------

## Дополнительные задания (со звёздочкой*)

------

### Задание 4*

1. Модуль vpc изменен так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.
Вызов модуля:
```
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-d", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-e", cidr = "10.0.2.0/24" }
  ]
}
```
План выполнения, результат из консоли YC.

![4_1_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_4_1_1.png)

![4_1_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_4_1_2.png)

![4_1_3](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_4_1_3.png)

![4_1_4](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_4_1_4.png)

![4_1_5](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_4_1_5.png)

---

### Задание 5*

1. Написан модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Использован ресурс yandex_mdb_mysql_cluster для передачи имени кластера и id сети.
2. Написан модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Использован ресурс yandex_mdb_mysql_database и yandex_mdb_mysql_user для передачи имени базы данных, имени пользователя и id кластера при вызове модуля.
3. С помощью данных модулей, создан кластер example из одного хоста, а затем добавлен в него БД test и пользователя app. После создания кластера изменена переменая HA и в кластер второй сервер.
4. Скриншоты результата.

![3_4_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_3_4_1.png)

![3_4_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_3_4_2.png)

---

### Задание 6*
1. Использован готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создан s3 бакет размером 1 ГБ.

![6](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_6.png)

---

### Задание 7*

1. Развернут локально vault, с помощью docker-compose.yml в проекте.

![7_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_7_1.png)

2. Выполнен вход в web-интерфейс и авторизация terraform в vault использован токен "education".

![7_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_7_2.png)

3. Создан новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example
secret data key: test
secret data value: congrats!

![7_3](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_7_3.png)

4. Этот секрет считан с помощью terraform и выведен в output:

```
provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}
data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value       = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}
```

![7_4](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_7_4.png)

5. Записать новый секрет в vault с помощью terraform.

![7_5](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_7_5.png)

---

### Задание 8*
C помощью terraform remote state разделен root модуль на два отдельных root-модуля: создание VPC (./modul-vpc), создание ВМ (./modul-vm).

![8_1](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_8_1.png)

![8_2](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_8_2.png)

![8_3](https://github.com/expgt/net-fops-hw-15-4/blob/terraform-04/15_4_8_3.png)
