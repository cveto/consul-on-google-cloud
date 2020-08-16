## Zardoz maintainer can only maintain services and nodes he is assigned to. He can nod give himself more access.

service_prefix "" {
  policy = "write"
}

node_prefix "" {
  policy = "write"
}

key_prefix "" {
  policy = "read"
}
