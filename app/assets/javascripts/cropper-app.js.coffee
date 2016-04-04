$(document).on 'change', '.cropper-input', ->
  input = this
  $input = $(input)
  $input.closest('form').addClass('cropper-form')
  $cropperContainer = $($input.attr('data-cropper-container'))
  $cropperContainer.find('> img').cropper('destroy').remove()

  return unless input.files?[0]

  loadImage input.files[0], (img)->
    $(img).appendTo($cropperContainer).cropper()
  , noRevoke: true

$(document).on 'submit', '.cropper-form', (e)->
  e.preventDefault()

  $form = $(this)
  $input = $form.find('.cropper-input')
  $cropperContainer = $($input.attr('data-cropper-container'))
  $cropperImg = $cropperContainer.find('> img')

  $cropperImg.cropper('getCroppedCanvas').toBlob (blob)->
    formData = new FormData($form[0])

    filename = $input.val().split(/\\/).pop()
    formData.append($input.attr('name'), blob, filename)

    $.ajax
      url: $form.attr('action')
      dataType: 'json'
      method: 'POST'
      data: formData
      processData: false
      contentType: false
      success: (data, status, xhr)->
        window.location = xhr.getResponseHeader('Location')
      error: -> alert('error')
