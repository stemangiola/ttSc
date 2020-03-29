#' nest
#'
#' @importFrom tidyr nest
#'
#' @param .data A tbl. (See tidyr)
#' @param ... Name-variable pairs of the form new_col = c(col1, col2, col3) (See tidyr)
#'
#' @return A tt object
#'
#' @examples
#'
#' nest(tidybulk(tidybulk::counts_mini, sample, transcript, count), data = -transcript)
#'
#'
#' @export
nest <- function (.data, ...)  {
	UseMethod("nest")
}

#' @export
nest.default <-  function (.data, ...)
{
	tidyr::nest(.data, ...)
}

#' @export
nest.tidybulk <- function (.data, ...)
{
	warning("nest is not fully supported yet by tidysc. The nested data frame has been reverted to tbl_df")

	.data %>%
		drop_class(c("ttSc", "tt")) %>%
		tidyr::nest(...)

	#   %>%
	#
	# 	# Attach attributes
	# 	reattach_internals(.data) %>%
	#
	# 	# Add class
	# 	add_class("tt") %>%
	# 	add_class("tidybulk")

}