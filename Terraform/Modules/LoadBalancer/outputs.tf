output "LB" {
  value = azurerm_lb.lb
}

output "Pool" {
  value = azurerm_lb_backend_address_pool.lb_backend
}