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
    -- Ally: Whistleblower
    Ally_Whistleblower1 = {
        name = "Ally_Whistleblower1",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_Whistleblower2 = {
        name = "Ally_Whistleblower2",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Whistleblower3 = {
        name = "Ally_Whistleblower3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Whistleblower4 = {
        name = "Ally_Whistleblower4",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Ally: Judge
    Ally_Judge1 = {
        name = "Ally_Judge1",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_Judge2 = {
        name = "Ally_Judge2",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Judge3 = {
        name = "Ally_Judge3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Judge4 = {
        name = "Ally_Judge4",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Ally: Public Opinion
    Ally_PublicOpinion1 = {
        name = "Ally_PublicOpinion1",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_PublicOpinion2 = {
        name = "Ally_PublicOpinion2",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_PublicOpinion3 = {
        name = "Ally_PublicOpinion3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_PublicOpinion4 = {
        name = "Ally_PublicOpinion4",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Ally: Diffamation
    Ally_Diffamation1 = {
        name = "Ally_Diffamation1",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_Diffamation2 = {
        name = "Ally_Diffamation2",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Diffamation3 = {
        name = "Ally_Diffamation3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Diffamation4 = {
        name = "Ally_Diffamation4",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Adversary: Random Event
    Adversary_RandomEvent1 = {
        name = "Adversary_RandomEvent1",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAdversary",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Adversary_RandomEvent2 = {
        name = "Adversary_RandomEvent2",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAdversary",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Adversary_RandomEvent3 = {
        name = "Adversary_RandomEvent3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAdversary",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Adversary_RandomEvent4 = {
        name = "Adversary_RandomEvent4",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAdversary",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Adversary: Secret Services
    Adversary_SecretServices1 = {
      name = "Adversary_SecretServices1",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "world", convex = false }
      }
    },
    Adversary_SecretServices2 = {
      name = "Adversary_SecretServices2",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "financial", convex = false }
      }
    },
    Adversary_SecretServices3 = {
      name = "Adversary_SecretServices3",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "state", convex = false }
      }
    },
    Adversary_SecretServices4 = {
      name = "Adversary_SecretServices4",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "sexual", convex = false }
      }
    },
    -- Adversary: Trials
    Adversary_Trials1 = {
      name = "Adversary_Trials1",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_Trials2 = {
      name = "Adversary_Trials2",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_Trials3 = {
      name = "Adversary_Trials3",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_Trials4 = {
      name = "Adversary_Trials4",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    -- Adversary: Spin Doctors
    Adversary_SpinDoctor1 = {
      name = "Adversary_SpinDoctor1",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_SpinDoctor2 = {
      name = "Adversary_SpinDoctor2",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_SpinDoctor3 = {
      name = "Adversary_SpinDoctor3",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_SpinDoctor4 = {
      name = "Adversary_SpinDoctor4",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    Adversary_SpinDoctor5 = {
      name = "Adversary_SpinDoctor5",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_SpinDoctor6 = {
      name = "Adversary_SpinDoctor6",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_SpinDoctor7 = {
      name = "Adversary_SpinDoctor7",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_SpinDoctor8 = {
      name = "Adversary_SpinDoctor8",
      team = "Enemy",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    -- Evidences
    Evidence_Document1 = {
      name = "Evidence_Document1",
      team = "Player",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "financial", convex = false }
      }
    }
}
