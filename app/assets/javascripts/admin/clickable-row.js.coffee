$ ->
 $('table').on 'click', '.clickable-row', ->
   window.location = $(this).data('href')