const updateReadState = () => {
  $('#links .update').on('click', (e) => {
    if(e.target.text != "Edit" && (e.target.getAttribute("href").indexOf("tag") <= -1))  {
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
  return(`<td ${link[0].id}>${link[0].title}</td><td style=background-${changeColor(link[0])}><a href=${link[0].url}>${link[0].url}</a></td><td class='message' ><a href='#' id=${link[0].id} >${replaceText(link[0])} </a></td><td>${loopsTags(link[1])}</td><td><a class="btn btn-xs btn-success" href='/links/${link[0].id}/edit'>Edit</a></td></tr>`);
};

const replaceText = (link) => {
  let val = "";
  link.read ? val = 'Mark as Unread' : val = 'Mark as Read';
  return val;
};

const loopsTags = (tags) => {

  let html = '';
   tags.map(function (tag) {
    html += `<a href="/tags/${tag.id}">${tag.name}</a> `;
  });
  return html;
};

const changeColor = (link) => {
  link.read  ? link.color = "color:yellow;" : link.color = "color:white;";
  return link.color;
};

const renderStatus = (link) => {
  let id = (link).replace( /(^.+\D)(\d+)(\D.+$)/i,'$2');
  $(".update" + " " + "#" + id).html(link);
};
