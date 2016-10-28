return {
  -- Newpaper
    Mediapart = {
      name = "Mediapart",
      team = "Player",
      tooltip = "mediapart",
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
      tooltip = "journalist_financial",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "financial", convex = true }
      }
    },
    World = {
      name = "World",
      team = "Player",
      tooltip = "journalist_world",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "world", convex = true }
      }
    },
    Sexual = {
      name = "Sexual",
      team = "Player",
      tooltip = "journalist_sexual",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "sexual", convex = true }
      }
    },
    State = {
      name = "State",
      team = "Player",
      tooltip = "journalist_state",
      pieceType = "PieceJournalist",
      connections = {
        N = { type = "state", convex = true }
      }
    },
    Joker=  {
      name = "Joker",
      team = "Player",
      tooltip = "journalist_joker",
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
      tooltip = "reac",
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
      tooltip = "socialo",
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
      tooltip = "facho",
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
      tooltip = "gaucho",
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
      tooltip = "centre",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "financial", convex = false },
        S = { type = "world", convex = false }
      }
    },
    Ecolo = {
      name = "Ecolo",
      team = "Enemy",
      tooltip = "ecolo",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "sexual", convex = false },
        S = { type = "state", convex = false }
      }
    },
    Ailleurs = {
      name = "Ailleurs",
      team = "Enemy",
      tooltip = "ailleurs",
      pieceType = "PieceCandidate",
      connections = {
        N = { type = "sexual", convex = false }
      }
    },
    -- Source
    Source_Secret1 = {
      name = "Source_Secret1",
      team = "Neutral",
      tooltip = "source_secret1",
      pieceType = "PieceSource",
      connections = {
        N = { type = "world", convex = false }
        }
      },
      Source_Secret2 = {
        name = "Source_Secret2",
        team = "Neutral",
        tooltip = "source_secret2",
        pieceType = "PieceSource",
        connections = {
          N = { type = "state", convex = false }
        }
      },
      Source_Secret3 = {
        name = "Source_Secret3",
        team = "Neutral",
        tooltip = "source_secret3",
        pieceType = "PieceSource",
        connections = {
          N = { type = "financial", convex = false }
        }
      },
      Source_Secret4 = {
          name = "Source_Secret4",
          team = "Neutral",
          tooltip = "source_secret1",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false }
          }
      },
      Source_Public1 = {
          name = "Source_Public1",
          team = "Neutral",
          tooltip = "source_public1",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "world", convex = false }
          }
      },
      Source_Public2 = {
          name = "Source_Public2",
          team = "Neutral",
          tooltip = "source_public2",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "state", convex = false }
          }
      },
      Source_Public3 = {
          name = "Source_Public3",
          team = "Neutral",
          tooltip = "source_public3",
          pieceType = "PieceSource",
          connections = {
            N = { type = "sexual", convex = false },
            S = { type = "financial", convex = false }
          }
      },
      Source_Public4 = {
          name = "Source_Public4",
          team = "Neutral",
          tooltip = "source_public1",
          pieceType = "PieceSource",
          connections = {
            N = { type = "state", convex = false },
            S = { type = "world", convex = false }
          }
      },
      Source_Public5 = {
          name = "Source_Public5",
          team = "Neutral",
          tooltip = "source_public2",
          pieceType = "PieceSource",
          connections = {
            N = { type = "state", convex = false },
            S = { type = "financial", convex = false }
          }
      },
      Source_Public6 = {
          name = "Source_Public6",
          team = "Neutral",
          tooltip = "source_public3",
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
        tooltip = "ally_whistleblower1",
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
        tooltip = "ally_whistleblower2",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Whistleblower3 = {
        name = "Ally_Whistleblower3",
        team = "Player",
        lifetime = 5,
        pieceType = "PieceAlly",
        tooltip = "ally_whistleblower3",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Whistleblower4 = {
        name = "Ally_Whistleblower4",
        team = "Player",
        tooltip = "ally_whistleblower1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Ally: Judge
    Ally_Judge1 = {
        name = "Ally_Judge1",
        tooltip = "ally_judge1",
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
        tooltip = "ally_judge1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Judge3 = {
        name = "Ally_Judge3",
        team = "Player",
        tooltip = "ally_judge1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Judge4 = {
        name = "Ally_Judge4",
        team = "Player",
        tooltip = "ally_judge1",
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
        tooltip = "ally_publicopinion1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_PublicOpinion2 = {
        name = "Ally_PublicOpinion2",
        team = "Player",
        tooltip = "ally_publicopinion1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_PublicOpinion3 = {
        name = "Ally_PublicOpinion3",
        team = "Player",
        tooltip = "ally_publicopinion1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_PublicOpinion4 = {
        name = "Ally_PublicOpinion4",
        team = "Player",
        tooltip = "ally_publicopinion1",
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
        tooltip = "ally_diffamation1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Ally_Diffamation2 = {
        name = "Ally_Diffamation2",
        team = "Player",
        tooltip = "ally_diffamation1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Ally_Diffamation3 = {
        name = "Ally_Diffamation3",
        team = "Player",
        tooltip = "ally_diffamation1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Ally_Diffamation4 = {
        name = "Ally_Diffamation4",
        team = "Player",
        tooltip = "ally_diffamation1",
        lifetime = 5,
        pieceType = "PieceAlly",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Adversary: Random Event
    Adversary_RandomEvent1 = {
        name = "Adversary_RandomEvent1",
        team = "Enemy",
        tooltip = "adversary_randomevent1",
        lifetime = 5,
        pieceType = "PieceEvent",
        connections = {
          N = { type = "financial", convex = true }
        }
    },
    Adversary_RandomEvent2 = {
        name = "Adversary_RandomEvent2",
        team = "Enemy",
        tooltip = "adversary_randomevent2",
        lifetime = 5,
        pieceType = "PieceEvent",
        connections = {
          N = { type = "sexual", convex = true }
        }
    },
    Adversary_RandomEvent3 = {
        name = "Adversary_RandomEvent3",
        team = "Enemy",
        tooltip = "adversary_randomevent3",
        lifetime = 5,
        pieceType = "PieceEvent",
        connections = {
          N = { type = "world", convex = true }
        }
    },
    Adversary_RandomEvent4 = {
        name = "Adversary_RandomEvent4",
        team = "Enemy",
        lifetime = 5,
        pieceType = "PieceEvent",
        tooltip = "adversary_randomevent4",
        connections = {
          N = { type = "state", convex = true }
        }
    },
    -- Adversary: Secret Services
    Adversary_SecretServices1 = {
      name = "Adversary_SecretServices1",
      team = "Enemy",
      tooltip = "adversary_secretservice1",
      pieceType = "PieceSecretService",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "world", convex = false }
      }
    },
    Adversary_SecretServices2 = {
      name = "Adversary_SecretServices2",
      team = "Enemy",
      tooltip = "adversary_secretservice2",
      pieceType = "PieceSecretService",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "financial", convex = false }
      }
    },
    Adversary_SecretServices3 = {
      name = "Adversary_SecretServices3",
      team = "Enemy",
      tooltip = "adversary_secretservice3",
      pieceType = "PieceSecretService",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "state", convex = false }
      }
    },
    Adversary_SecretServices4 = {
      name = "Adversary_SecretServices4",
      team = "Enemy",
      tooltip = "adversary_secretservice1",
      pieceType = "PieceSecretService",
      connections = {
        E = { type = "world", convex = true },
        W = { type = "sexual", convex = false }
      }
    },
    -- Adversary: Trials
    Adversary_Trials1 = {
      name = "Adversary_Trials1",
      team = "Enemy",
      tooltip = "adversary_trial1",
      pieceType = "PieceSecretService",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_Trials2 = {
      name = "Adversary_Trials2",
      team = "Enemy",
      tooltip = "adversary_trial2",
      pieceType = "PieceSecretService",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_Trials3 = {
      name = "Adversary_Trials3",
      team = "Enemy",
      tooltip = "adversary_trial3",
      pieceType = "PieceSecretService",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_Trials4 = {
      name = "Adversary_Trials4",
      team = "Enemy",
      tooltip = "adversary_trial1",
      pieceType = "PieceSecretService",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    -- Adversary: Spin Doctors
    Adversary_SpinDoctor1 = {
      name = "Adversary_SpinDoctor1",
      team = "Enemy",
      tooltip = "adversary_spindoctor1",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_SpinDoctor2 = {
      name = "Adversary_SpinDoctor2",
      team = "Enemy",
      tooltip = "adversary_spindoctor2",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_SpinDoctor3 = {
      name = "Adversary_SpinDoctor3",
      team = "Enemy",
      tooltip = "adversary_spindoctor3",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_SpinDoctor4 = {
      name = "Adversary_SpinDoctor4",
      team = "Enemy",
      tooltip = "adversary_spindoctor1",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    Adversary_SpinDoctor5 = {
      name = "Adversary_SpinDoctor5",
      team = "Enemy",
      tooltip = "adversary_spindoctor2",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Adversary_SpinDoctor6 = {
      name = "Adversary_SpinDoctor6",
      team = "Enemy",
        tooltip = "adversary_spindoctor3",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Adversary_SpinDoctor7 = {
      name = "Adversary_SpinDoctor7",
      team = "Enemy",
      tooltip = "adversary_spindoctor1",
      pieceType = "PieceAdversary",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Adversary_SpinDoctor8 = {
      name = "Adversary_SpinDoctor8",
      team = "Enemy",
      tooltip = "adversary_spindoctor2",
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
      tooltip = "evidence_document1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Evidence_Document2 = {
      name = "Evidence_Document2",
      team = "Player",
      tooltip = "evidence_document2",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Evidence_Document3 = {
      name = "Evidence_Document3",
      team = "Player",
      tooltip = "evidence_document3",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Evidence_Document4 = {
      name = "Evidence_Document4",
      team = "Player",
      tooltip = "evidence_document1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "financial", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    Evidence_Tape1 = {
      name = "Evidence_Tape1",
      team = "Player",
      tooltip = "evidence_tape1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Evidence_Tape2 = {
      name = "Evidence_Tape2",
      team = "Player",
      tooltip = "evidence_tape2",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Evidence_Tape3 = {
      name = "Evidence_Tape3",
      team = "Player",
      tooltip = "evidence_tape3",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Evidence_Tape4 = {
      name = "Evidence_Tape4",
      team = "Player",
      tooltip = "evidence_tape1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "state", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    Evidence_Video1 = {
      name = "Evidence_Video1",
      team = "Player",
      tooltip = "evidence_video1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "world", convex = true },
        E = { type = "financial", convex = false }
      }
    },
    Evidence_Video2 = {
      name = "Evidence_Video2",
      team = "Player",
      tooltip = "evidence_video2",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "world", convex = true },
        E = { type = "world", convex = false }
      }
    },
    Evidence_Video3 = {
      name = "Evidence_Video3",
      team = "Player",
      tooltip = "evidence_video3",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "world", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Evidence_Video4 = {
      name = "Evidence_Video4",
      team = "Player",
      tooltip = "evidence_video1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "world", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    Evidence_Photo1 = {
        name = "Evidence_Photo1",
        team = "Player",
        tooltip = "evidence_photo1",
        pieceType = "PieceEvidence",
        connections = {
          W = { type = "sexual", convex = true },
          E = { type = "financial", convex = false }
      }
    },
    Evidence_Photo2 = {
      name = "Evidence_Photo2",
      team = "Player",
      tooltip = "evidence_photo2",
      pieceType = "PieceEvidence",
      connections = {
          W = { type = "sexual", convex = true },
          E = { type = "world", convex = false }
      }
    },
    Evidence_Photo3 = {
      name = "Evidence_Photo3",
      team = "Player",
      tooltip = "evidence_photo3",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "state", convex = false }
      }
    },
    Evidence_Photo4 = {
      name = "Evidence_Photo4",
      team = "Player",
      tooltip = "evidence_photo1",
      pieceType = "PieceEvidence",
      connections = {
        W = { type = "sexual", convex = true },
        E = { type = "sexual", convex = false }
      }
    },
    -- Evidence: Secret Source
    Evidence_SecretSource1 = {
        name = "Evidence_SecretSource1",
        team = "Player",
        tooltip = "evidence_secretsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "sexual", convex = true },
          E = { type = "sexual", convex = false },
          W = { type = "sexual", convex = false }
      }
    },
    Evidence_SecretSource2 = {
        name = "Evidence_SecretSource2",
        team = "Player",
        tooltip = "evidence_secretsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "sexual", convex = false },
          E = { type = "sexual", convex = false },
          W = { type = "sexual", convex = true }
      }
    },
    Evidence_SecretSource3 = {
        name = "Evidence_SecretSource3",
        team = "Player",
        tooltip = "evidence_secretsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "financial", convex = true },
          S = { type = "financial", convex = true },
          E = { type = "financial", convex = false },
          W = { type = "financial", convex = false }
      }
    },
    Evidence_SecretSource4 = {
        name = "Evidence_SecretSource4",
        team = "Player",
        tooltip = "evidence_secretsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "financial", convex = true },
          S = { type = "financial", convex = false },
          E = { type = "financial", convex = false },
          W = { type = "financial", convex = true }
      }
    },
    Evidence_SecretSource5 = {
        name = "Evidence_SecretSource5",
        team = "Player",
        tooltip = "evidence_secretsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "world", convex = true },
          S = { type = "world", convex = true },
          E = { type = "world", convex = false },
          W = { type = "world", convex = false }
      }
    },
    Evidence_SecretSource6 = {
        name = "Evidence_SecretSource6",
        team = "Player",
        tooltip = "evidence_secretsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "world", convex = true },
          S = { type = "world", convex = false },
          E = { type = "world", convex = false },
          W = { type = "world", convex = true }
      }
    },
    Evidence_SecretSource7 = {
        name = "Evidence_SecretSource7",
        team = "Player",
        tooltip = "evidence_secretsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "state", convex = true },
          E = { type = "state", convex = false },
          W = { type = "state", convex = false }
      }
    },
    Evidence_SecretSource8 = {
        name = "Evidence_SecretSource8",
        team = "Player",
        tooltip = "evidence_secretsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "state", convex = false },
          E = { type = "state", convex = false },
          W = { type = "state", convex = true }
      }
    },
    -- Evidence Public Source
    Evidence_PublicSource1 = {
        name = "Evidence_PublicSource1",
        team = "Player",
        tooltip = "evidence_publicsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "sexual", convex = false },
          E = { type = "financial", convex = false },
          W = { type = "financial", convex = true }
      }
    },
    Evidence_PublicSource2 = {
        name = "Evidence_PublicSource2",
        team = "Player",
        tooltip = "evidence_publicsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "financial", convex = false },
          E = { type = "sexual", convex = false },
          W = { type = "financial", convex = true }
      }
    },
    Evidence_PublicSource3 = {
        name = "Evidence_PublicSource3",
        team = "Player",
        tooltip = "evidence_publicsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "sexual", convex = false },
          E = { type = "state", convex = false },
          W = { type = "state", convex = true }
      }
    },
    Evidence_PublicSource4 = {
        name = "Evidence_PublicSource4",
        team = "Player",
        tooltip = "evidence_publicsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "state", convex = false },
          E = { type = "sexual", convex = false },
          W = { type = "state", convex = true }
      }
    },
    Evidence_PublicSource5 = {
        name = "Evidence_PublicSource5",
        team = "Player",
        tooltip = "evidence_publicsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "sexual", convex = false },
          E = { type = "world", convex = false },
          W = { type = "world", convex = true }
      }
    },
    Evidence_PublicSource6 = {
        name = "Evidence_PublicSource6",
        team = "Player",
        tooltip = "evidence_publicsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "sexual", convex = true },
          S = { type = "world", convex = false },
          E = { type = "sexual", convex = false },
          W = { type = "world", convex = true }
      }
    },
    Evidence_PublicSource7 = {
        name = "Evidence_PublicSource7",
        team = "Player",
        tooltip = "evidence_publicsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "state", convex = false },
          E = { type = "world", convex = false },
          W = { type = "world", convex = true }
      }
    },
    Evidence_PublicSource8 = {
        name = "Evidence_PublicSource8",
        team = "Player",
        tooltip = "evidence_publicsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "world", convex = false },
          E = { type = "state", convex = false },
          W = { type = "world", convex = true }
      }
    },
    Evidence_PublicSource9 = {
        name = "Evidence_PublicSource9",
        team = "Player",
        tooltip = "evidence_publicsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "state", convex = false },
          E = { type = "financial", convex = false },
          W = { type = "financial", convex = true }
      }
    },
    Evidence_PublicSource10 = {
        name = "Evidence_PublicSource10",
        team = "Player",
        tooltip = "evidence_publicsource1",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state",     convex = true },
          S = { type = "financial", convex = false },
          E = { type = "state",     convex = false },
          W = { type = "financial", convex = true }
      }
    },
    Evidence_PublicSource11 = {
        name = "Evidence_PublicSource11",
        team = "Player",
        tooltip = "evidence_publicsource2",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state",     convex = true },
          S = { type = "world",     convex = false },
          E = { type = "state",     convex = false },
          W = { type = "world",     convex = true }
      }
    },
    Evidence_PublicSource12 = {
        name = "Evidence_PublicSource12",
        team = "Player",
        tooltip = "evidence_publicsource3",
        pieceType = "PieceEvidence",
        connections = {
          N = { type = "state", convex = true },
          S = { type = "state", convex = false },
          E = { type = "world", convex = false },
          W = { type = "world", convex = true }
      }
    }
}
