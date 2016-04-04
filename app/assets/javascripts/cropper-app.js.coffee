$(document).on 'change', '.cropper-input', ->
  input = this
  $input = $(input)
  $cropperContainer = $($input.attr('data-cropper-container'))
  $cropperContainer.find('img').cropper('destroy').remove()

  return unless input.files?[0]

  loadImage input.files[0], (img)->
    $(img).appendTo($cropperContainer).cropper()
  , noRevoke: true
