# resource "aws_vpc_peering_connection" "default" {
#   count = var.is_peering_enabled ? 1 : 0
#  // peer_owner_id = var.peer_owner_id
#   peer_vpc_id   = data.aws_vpc.default.id
#   vpc_id        = aws_vpc.main.id

#   accepter {
#     allow_remote_vpc_dns_resolution = true
#   }

#   requester {
#     allow_remote_vpc_dns_resolution = true
#   }

#   tags = {
#     Name  = "VPC_PEERING"
#   }
# }

# resource "aws_route" "public_peering" {

#     route_table_id = aws_route_table.public.id
#     destination_cidr_block = data.aws_vpc.default.cidr_block
#     vpc_peering_connection_id = aws_vpc_peering_connection.default.id
    
# }

# resource "aws_route" "default_peering" {

#     route_table_id = aws_route.private.id
#     destination_cidr_block = var.vpc_cidr
#     vpc_peering_connection_id = aws_vpc_peering_connection.default.id
    
# }