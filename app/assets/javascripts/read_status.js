const updateReadState = () => {
  $('#links .update').on('click', (e) => {
    if(e.target.text != "Edit") {
      e.preventDefault();
      let id = e.target.id;
      query(id);
    }
  });
};

const query = (id) => {
  const num = id;
  $.ajax({
    url: '/links/' + id,
    method: 'put',
    data: { id: id }
  }).then(createUpdateHTML).then(renderStatus);
};

const createUpdateHTML = (link) => {
  return(`<td ${link.id}>${link.title}</td><td style=background-${changeColor(link)}><a href=${link.url}>${link.url}</a></td><td class='message' ><a href='#' id=${link.id} >${replaceText(link)} </a></td><td></td><td><a class="btn btn-xs btn-success" href='/links/${link.id}/edit'>Edit</a></td></tr>`);
};

const replaceText = (link) => {
  let val = "";
  link.read ? val = 'Mark as Unread' : val = 'Mark as Read';
  return val;
};

const changeColor = (link) => {
  link.read  ? link.color = "color:yellow;" : link.color = "color:white;";
  return link.color;
};

const renderStatus = (link) => {
  let id = (link).replace( /(^.+\D)(\d+)(\D.+$)/i,'$2');
  $(".update" + " " + "#" + id).html(link);
};
