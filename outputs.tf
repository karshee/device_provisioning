output "iot_certificate_arn" {
  description = "arn of iot certificate"
  value       = aws_iot_certificate.cert.arn
}
output "iot_certificate_key" {
  description = "private key of iot certificate"
  value       = aws_iot_certificate.cert.private_key
  sensitive   = true
}
output "iot_certificate_pem" {
  description = "cert pem of iot certificate"
  value       = aws_iot_certificate.cert.certificate_pem
  sensitive   = true
}