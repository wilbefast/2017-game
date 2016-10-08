return {
  -- Newpaper
    Mediapart = {
      name = "Mediapart",
      team = "Player",
      pieceType = "PieceNewspaper",
      connections = {
        E = { type = "financial", convex = false },
        W = { type = "world", convex = false }
      }
    },
    -- Journalists
    Financial = {
      name = "Financial",
      team = "Player",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "financial", convex = true }
      }
    },
    World = {
      name = "World",
      team = "Player",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "world", convex = true }
      }
    },
    Sexual = {
      name = "Sexual",
      team = "Player",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "sexual", convex = true }
      }
    },
    State = {
      name = "State",
      team = "Player",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "state", convex = true }
      }
    },
    Joker=  {
      name = "Joker",
      team = "Player",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "financial", convex = true },
        S = { type = "world", convex = true },
        E = { type = "sexual", convex = true },
        W = { type = "state", convex = true }
      }
    },
    -- Candidates
    Reac = {
      name = "Reac",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        S = { type = "world", convex = false },
        E = { type = "sexual", convex = false },
        W = { type = "state", convex = false }
      }
    },
    Socialo = {
      name = "Socialo",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        S = { type = "world", convex = false },
        E = { type = "sexual", convex = false },
        W = { type = "state", convex = false }
      }
    },
    Facho = {
      name = "Facho",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        S = { type = "world", convex = false },
        W = { type = "state", convex = false }
      }
    },
    Gaucho = {
      name = "Gaucho",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        E = { type = "sexual", convex = false },
        W = { type = "state", convex = false }
      }
    },
    Centre = {
      name = "Centre",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        S = { type = "world", convex = false }
      }
    },
    Ecolo = {
      name = "Ecolo",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "sexual", convex = false },
        S = { type = "state", convex = false }
      }
    },
    Ailleurs = {
      name = "Ailleurs",
      team = "Enemy",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "sexual", convex = false }
      }
    },
    -- Source
    Source_Secret1 = {
      name = "Source_Secret1",
      team = "Neutral",
      pieceType = "PieceSource",
      connections = {
        N = { type = "world", convex = false }
        }
      },
      Source_Secret2 = {
        name = "Source_Secret2",
        team = "Neutral",
        pieceType = "PieceSource",
        connections = {
          N = { type = "state", convex = false }
        }
      },
      Source_Secret3 = {
        name = "Source_Secret3",
        team = "Neutral",
        pieceType = "PieceSource",
        connections = {
          N = { type = "financial", convex = false }
        }
      },
      Source_Secret4 = {
          name = "Source_Secret4",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false }
          }
      },
      Source_Public1 = {
          name = "Source_Public1",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "world", convex = false }
          }
      },
      Source_Public2 = {
          name = "Source_Public2",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "state", convex = false }
          }
      },
      Source_Public3 = {
          name = "Source_Public3",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "financial", convex = false }
          }
      },
      Source_Public4 = {
          name = "Source_Public4",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "state", convex = false },
            S = { type = "world", convex = false }
          }
      },
      Source_Public5 = {
          name = "Source_Public5",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "state", convex = false },
            S = { type = "financial", convex = false }
          }
      },
      Source_Public6 = {
          name = "Source_Public6",
          team = "Neutral",
          pieceType = "PieceSource",
          connections = {
            N = { type = "financial", convex = false },
            S = { type = "world", convex = false }
          }
      },
    -- Adversary
    Intelligence = {
      name = "Intelligence",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        N = { type = "world", convex = true }
      }
    }
}
