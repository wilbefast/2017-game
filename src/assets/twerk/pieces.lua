return {
  Mediapart = {
    name = "Mediapart",
    connections = {
      E = { type = "financial", convex = false },
      W = { type = "world", convex = false }
    }
  },
  Reac = {
    name = "Reac",
    connections = {
      N = { type = "financial", convex = true },
      S = { type = "world", convex = true },
      E = { type = "sexual", convex = true },
      W = { type = "state", convex = true }
    }
  },
  Ecolo = {
    name = "Ecolo",
    connections = {
      N = { type = "sexual", convex = true },
      S = { type = "state", convex = true }
    }
  }
}
