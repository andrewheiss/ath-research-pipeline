library(googlesheets4)

sheets_auth(path = ".secrets/ath-projects-da65d73c80f5.json")

sheet_id <- "1yPaSMb_0Qr3AxFzOIwVMrosDGpt8t7pzeLBGA7ncvWM"

# pipeline_meta <- sheets_get(sheet_id)

score_lookup <- read_sheet(sheet_id, sheet = "Status/score lookup") %>% 
  mutate(Status_plot = str_replace_all(Status, "; ", ";\n"),
         Status_plot = str_replace_all(Status_plot, "Presented at ", "Presented at\n"),
         Status_plot = str_replace_all(Status_plot, "review post", "review\npost")) %>% 
  mutate(points = map_chr(Score, ~pluralize("point", n = .)),
         Status_plot = paste0(Status_plot, "\n(", Score, " ", points, ")"))

load_pipeline_data <- function() {
  read_sheet(sheet_id, sheet = "Data")
}

pipeline <- load_pipeline_data()
