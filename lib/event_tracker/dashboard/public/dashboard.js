function confirmReset() {
  var agree=confirm("This will delete all data for this event?");
  if (agree)
    return true;
  else
    return false;
}

function confirmDelete() {
  var agree=confirm("Are you sure you want to delete this event and all its data?");
  if (agree)
    return true;
  else
    return false;
}