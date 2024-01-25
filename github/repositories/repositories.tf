resource "github_repository" "repositories" {
    for_each = { for repo in var.repositories : repo.name => repo }
    name        = each.value.name
    description = each.value.description
    visibility = each.value.visibility
    has_issues = each.value.has_issues
    has_discussions = each.value.has_discussions
    has_projects = each.value.has_projects
    has_wiki = each.value.has_wiki
}
