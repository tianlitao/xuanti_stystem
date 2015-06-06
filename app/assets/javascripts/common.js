function score(){
    var score =  $('#score').val();
    var id = $('#id').val()
    window.location.href = '/teacher/modify_score?id=' +id + '&&score=' + score;
}