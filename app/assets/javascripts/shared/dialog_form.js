function submit_dialog_form(btn){
  $(btn).text('正在提交...');
  $(btn).parent().parent().find('form').submit();
  $(btn).disable();
}
function submit_this_form(btn){
  $(btn).closest('form').submit();
}
function remove_modal(btn){
  $(btn).closest('.modal').modal('hide').remove();
}

