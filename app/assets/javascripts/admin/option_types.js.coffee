jQuery ->
  $(document).ready ->
    warn_user = (text) ->
      $("#variant-error-messages .warning-dialog").html text
      $("#variant-error-messages").css("background-color": "#fff").animate(
        "background-color": "#f2dede"
      , 1000, ->
        setTimeout (->
          $("#variant-error-messages").fadeOut "slow"
          $("#variant-error-messages .warning-dialog").html ""
        ), 1000
      ).show()
      return
    if $('#option_type_product_based:checked').length > 0
      $('#option_values tr td').find('input').each( ->
        if( !$(this).prop('id') )
          $(this).attr 'id', (new Date().getTime())
      )
      $('#new_add_option_value').appendTo("#add_variant")

      $('#add_variant').click ->
        if $('#add_variant_id').val() == ''
          $('#option_values tr:first').remove()
          warn_user('first select a variant from the select box')
          return false

        #WET
        variant_name = $('#s2id_add_variant_id span').text()
        $('#option_values tr:first td[class="name"] input').val variant_name
        $('#option_values tr:first td[class="presentation"] input').val variant_name

        obj = $('#option_values tr:first td[class="name"] input')
        hiddenInput = $('<input/>',{
          type:  'hidden',
          id:    obj.attr("id").replace("name", "variant_id"),
          name:  obj.attr("name").replace("name", "variant_id")
          value: $('#add_variant_id').val(),
        })
        hiddenInput.appendTo('#option_values tr:first-child')
        $("#option_values tr:first-child").css("background-color": "#9fc820").animate
          "background-color": "#fff"
          , 1000
        return

      $('#option_values tr td:nth-child(5) input[type="checkbox"]:checked').addClass 'Checked'
      $('#option_values tr td:nth-child(5) input[type="checkbox"]').click ->
        if !$(this).hasClass('Checked')
          $('#option_values tr td:nth-child(5) input.Checked').removeClass('Checked')
          $('#option_values tr td:nth-child(5) input[type="checkbox"]').prop 'checked', ''
          $(this).prop('checked', 'checked').addClass 'Checked'
        else
          $(this).removeClass 'Checked'
        return
