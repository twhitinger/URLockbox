class filterReadState {
  constructor() {
    this.unread = true;
    this.array = [];
  }
}

const filter = () => {
  const state = new filterReadState();
  $("#read-status").on('click', (e) => {
    if (state.array.length > 0 && state.unread === false) {
      fadeIn(e, state.array);
    } else if (state.array.length > 0 && state.unread === true) {
      fadeIn(e, state.array);
    }
    $('#links .update .link').each(function (_index, status) {
      $status = $(status).text();
      if ($status.includes("Unread") && state.unread === true) {
        fadeOut(e, state.array, this);
      } else if ($status.includes("Read") && state.unread === false) {
        fadeOut(e, state.array, this);
      }
    });
    if(state.array.length > 0){
      state.unread = !state.unread;
    }
  });
};

const fadeOut = (e, array, self) => {
  e.preventDefault();
  array.push($(self).closest("tr"));
  $(self).closest("tr").fadeOut();
};

const fadeIn = (e, array) => {
  array.map(function (status) {
    e.preventDefault();
    status.fadeIn();
  });
  array = [];
};
