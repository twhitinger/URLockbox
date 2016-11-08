const searchPage = () =>  {
  $("#search-bar").on("keyup", function (){
    const currentSearch = this.value.toLowerCase();

    $('#links .update .link').each(function (_index, link) {
      $link = $(link).text().toLowerCase();
      if ($link.includes(currentSearch)) {

        $(this).fadeIn();
      } else {

        $(this).fadeOut();
      }
    });
  });
};
