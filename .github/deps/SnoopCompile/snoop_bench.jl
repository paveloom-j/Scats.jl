using SnoopCompile

botconfig = BotConfig(
  "Scats";
  yml_path = "SnoopCompile.yml",
  check_eval = true,
)

snoop_bench(
  botconfig,
)
