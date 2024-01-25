resource "github_team_membership" "team_memberships" {
    for_each = { for user in var.users : user.name => user }
    team_id  = each.value.team
    username = each.value.name
    role     = each.value.role
}