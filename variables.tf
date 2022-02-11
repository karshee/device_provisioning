
variable "iam_role_name" {
  description = "Name of IAM role"
  type        = string
  #default     = "KVSCameraCertificateBasedIAMRole-test"
}
variable "iam_policy_name" {
  description = "Name of IAM policy - in charge of KVS"
  type        = string
  #default     = "iam_policy_kvs-test"
}
variable "iot_role_alias_name" {
  description = "name of IOT role alias"
  type        = string
  #default     = "KvsCameraIoTRoleAlias-test"
}
variable "role_alias_duration" {
  description = "credential duration of role-alias"
  type        = number
  #default     = 3600
}
variable "camera_iot_policy" {
  description = "policy name for role alias to be attached to cert"
  type        = string
  #default     = "KvsCameraIoTPolicy-test"
}
variable "iot_thing_name" {
  description = "name of IOT thing - very important!"
  type        = string
  #default     = "arrowtec_drone_001-test"
}