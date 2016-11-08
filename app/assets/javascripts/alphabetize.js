
const sort = () => {
  $('#sort-alphabetically').on('click', function () {
    $('#links .update').html(alphabetize($('.link')));
  });
};


const alphabetize = (links) => {
  return links.sort(function (a, b) {
    const nameA = $(a).find("#title").text().toLowerCase();
    const nameB = $(b).find("#title").text().toLowerCase();
    if (nameA < nameB) {
      return -1;
    } else if (nameA > nameB) {
      return 1;
      return 0;
    }
  });
};
