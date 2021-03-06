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
nest.tidysc <- function (.data, ...)
{
	warning("nest is not fully supported yet by tidysc. The nested data frame has been reverted to tbl_df")

	.data %>%
		drop_class(c("tidysc", "tt")) %>%
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

#' @export
extract <- function  (data, col, into, regex = "([[:alnum:]]+)", remove = TRUE, 
										 convert = FALSE, ...)   {
	UseMethod("extract")
}

#' @export
extract.default <-  function  (data, col, into, regex = "([[:alnum:]]+)", remove = TRUE, 
															convert = FALSE, ...) 
{
	col = enquo(col)
	tidyr::extract(col = !!col, into = into, regex = regex, remove = remove, 
								 convert = convert, ...) 
}

#' @export
extract.tidysc <- function  (data, col, into, regex = "([[:alnum:]]+)", remove = TRUE, 
														convert = FALSE, ...) 
{
	
	col = enquo(col)
	
	data %>%
		drop_class(c("tidysc", "tt")) %>%
		tidyr::extract(col = !!col, into = into, regex = regex, remove = remove, 
									 convert = convert, ...)  %>%
		
		# Update seurat
		add_attr(data %>% attr("seurat"), "seurat") %>%
		add_attr(data %>% attr("parameters"), "parameters") %>%
		update_metadata_sc() %>%
		
		# Add tt class
		add_class("tt") %>%
		add_class("tidysc")
		
	
}