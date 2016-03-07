create user SessIdTechUser password "Initial234";
alter user SessIdTechUser disable password lifetime;
grant REPO.READ on "training.dlapanik.SessionId.private" to SessIdTechUser;