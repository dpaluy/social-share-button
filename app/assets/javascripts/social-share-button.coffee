window.SocialShareButton =
  openUrl : (url) ->
    window.open(url)
    false

  share : (el) ->
    site    = $(el).data('site')
    title   = encodeURIComponent($(el).parent().data('title') || '')
    tweet   = encodeURIComponent($(el).parent().data('tweet') || '')
    img     = encodeURIComponent($(el).parent().data("img") || '')
    url     = encodeURIComponent($(el).parent().data("url") || '')
    source  = encodeURIComponent($(el).parent().data("source") || '')
    summary = encodeURIComponent($(el).parent().data("summary") || '')
    if url.length == 0
      url = encodeURIComponent(location.href)
    switch site
      when "email"
        SocialShareButton.openUrl("mailto:?to=&subject=#{title}&body=#{url}")
      when "twitter"
        SocialShareButton.openUrl("https://twitter.com/intent/tweet?source=webclient&text=#{tweet}")
      when "facebook"
        SocialShareButton.openUrl("https://www.facebook.com/sharer/sharer.php?u=#{url}")
      when "linkedin"
        SocialShareButton.openUrl("https://www.linkedin.com/shareArticle?summary=#{summary}&url=#{url}&source=#{source}&title=#{title}&mini=true")
      when "google_plus"
        SocialShareButton.openUrl("https://plus.google.com/share?url=#{url}")
      when "google_bookmark"
        SocialShareButton.openUrl("https://www.google.com/bookmarks/mark?op=edit&output=popup&bkmk=#{url}&title=#{title}")
      when "pinterest"
        SocialShareButton.openUrl("http://www.pinterest.com/pin/create/button/?url=#{url}&media=#{img}&description=#{summary}")
      when "tumblr"
        get_tumblr_extra = (param) ->
          cutom_data = $(el).attr("data-#{param}")
          encodeURIComponent(cutom_data) if cutom_data

        tumblr_params = ->
          path = get_tumblr_extra('type') || 'link'

          params = switch path
            when 'text'
              title = get_tumblr_extra('title') || title
              "title=#{title}"
            when 'photo'
              title = get_tumblr_extra('caption') || title
              source = get_tumblr_extra('source') || img
              "caption=#{title}&source=#{source}"
            when 'quote'
              quote = get_tumblr_extra('quote') || title
              source = get_tumblr_extra('source') || ''
              "quote=#{quote}&source=#{source}"
            else # actually, it's a link clause
              title = get_tumblr_extra('title') || title
              url = get_tumblr_extra('url') || url
              "name=#{title}&url=#{url}"


          "/#{path}?#{params}"

        SocialShareButton.openUrl("http://www.tumblr.com/share#{tumblr_params()}")
    false
