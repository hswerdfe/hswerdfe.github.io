

BASE_URL <- 'https://hswerdfe.github.io/docs/posts'

share_df <- 
  read.csv(
    text="glue_url,img, alt
http://www.linkedin.com/shareArticle?url={url},img/in.jfif,LinkedIn
https://www.reddit.com/submit?url={url},img/Reddit.webp,Reddit
https://www.twitter.com/share?url={url},img/Twitter.webp,Twitter") |> tibble::as_tibble()




url_to_share <- function(){
  #'https://stackoverflow.com/questions/51165818/blogdown-and-links-on-social-sharing-buttons'
  paste0(BASE_URL, stringr::str_remove(getwd(), here::here()))
}





image_link <- function(image,url,...){
  htmltools::a(
    href=url,
    htmltools::img(src=image,...)
  )
}





share_url <- function(glue_url, url){
  # url <- 'https://google.ca/'
  glue_url |> 
    purrr::map(~{glue::glue(.x)}) |> unlist()
}






share_img <- function(glue_url,
                      image = "img/in.jfif",
                      url = url_to_share(),
                      width = '20px',
                      ...){
  
  image <- share_df$img
  purrr::map2(image, share_url(glue_url, url),
              \(.image, .share_url){
                image_link(.image, 
                           .share_url, 
                           width=width, 
                           ...)
              }) 
}
