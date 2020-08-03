using SnoopCompile
using Base: include

botconfig = BotConfig(
  "Scats";
  yml_path = "SnoopCompile.yml",
  check_eval = true,
)

snoop_bot(
  botconfig,
)
