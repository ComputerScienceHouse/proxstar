/*jshint esversion: 6 */

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});

$("#delete-vm").click(function(){
    const vmname = $(this).data('vmname');
    swal({
        title: `Are you sure you want to delete ${vmname}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "Delete",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willDelete) => {
        if (willDelete) {
            const vmid = $(this).data('vmid');
            fetch(`/vm/${vmid}/delete`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${vmname} is now being deleted.`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = "/";
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to delete ${vmname}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$("#stop-vm").click(function(){
    const vmname = $(this).data('vmname');
    swal({
        title: `Are you sure you want to stop ${vmname}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "Stop",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willStop) => {
        if (willStop) {
            const vmid = $(this).data('vmid')
            fetch(`/vm/${vmid}/power/stop`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${vmname} is now stopping!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to stop ${vmname}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$("#reset-vm").click(function(){
    const vmname = $(this).data('vmname');
    swal({
        title: `Are you sure you want to reset ${vmname}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "Reset",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willReset) => {
        if (willReset) {
            const vmid = $(this).data('vmid');
            fetch(`/vm/${vmid}/power/reset`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${vmname} is now resetting!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to reset ${vmname}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$("#shutdown-vm").click(function(){
    const vmname = $(this).data('vmname');
    swal({
        title: `Are you sure you want to shutdown ${vmname}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "Shutdown",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willShutdown) => {
        if (willShutdown) {
            const vmid = $(this).data('vmid');
            fetch(`/vm/${vmid}/power/shutdown`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${vmname} is now shutting down!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to shutdown ${vmname}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$("#suspend-vm").click(function(){
    const vmname = $(this).data('vmname');
    swal({
        title: `Are you sure you want to suspend ${vmname}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "Suspend",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willSuspend) => {
        if (willSuspend) {
            const vmid = $(this).data('vmid');
            fetch(`/vm/${vmid}/power/suspend`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${vmname} is now suspending!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to suspend ${vmname}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$("#start-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid');
    fetch(`/vm/${vmid}/power/start`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
        return swal(`${vmname} is now starting!`, {
            icon: "success",
        }); 
    }).then(() => {
        window.location = `/vm/${vmid}`;
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to start ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#resume-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid');
    fetch(`/vm/${vmid}/power/resume`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
        return swal(`${vmname} is now resuming!`, {
            icon: "success",
        }); 
    }).then(() => {
        window.location = `/vm/${vmid}`;
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to resume ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#eject-iso").click(function(){
    const iso = $(this).data('iso');
    swal({
        title: `Are you sure you want to eject ${iso}?`,
        icon: "warning",
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            eject: {
                text: "Eject",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willEject) => {
        if (willEject) {
            const vmid = $(this).data('vmid');
            fetch(`/vm/${vmid}/eject`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`${iso} is now ejecting!`, {
                    icon: "success",
                    buttons: {
                        ok: {
                            text: "OK",
                            closeModal: true,
                            className: "",
                        }
                    }
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to eject ${iso}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});


$("#change-iso").click(function(){
    fetch(`/isos`, {
        credentials: 'same-origin',
    }).then((response) => {
        return response.text()
    }).then((text) => {
        var isos = text.split(',');
        var iso_list = document.createElement('select');
        for (i = 0; i < isos.length; i++) {
            iso_list.appendChild(new Option(isos[i], isos[i]));
        }
        swal({
            title: 'Choose an ISO to mount:',
            content: iso_list,
            buttons: {
                cancel: {
                    text: "Cancel",
                    visible: true,
                    closeModal: true,
                    className: "",
                },
                select: {
                    text: "Select",
                    closeModal: false,
                    className: "swal-button--danger",
                }
            },
            dangerMode: true,
        })
        .then((willChange) => {
            if (willChange) {
                const vmid = $(this).data('vmid');
                const iso = $(iso_list).val();
                fetch(`/vm/${vmid}/mount/${iso}`, {
                    credentials: 'same-origin',
                    method: 'post'
                }).then((response) => {
                    return swal(`${iso} is now being mounted!`, {
                        icon: "success",
                        buttons: {
                            ok: {
                                text: "OK",
                                closeModal: true,
                                className: "",
                            }
                        }
                    });
                }).then(() => {
                    window.location = `/vm/${vmid}`;
                }).catch(err => {
                    if (err) {
                        swal("Uh oh...", `Unable to mount ${iso}. Please try again later.`, "error");
                    } else {
                        swal.stopLoading();
                        swal.close();
                    }
                });
            }
       });
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to retrieve available ISOs. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#renew-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid');
    fetch(`/vm/${vmid}/renew`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
        return swal(`${vmname} has been renewed!`, {
            icon: "success",
        });
    }).then(() => {
        window.location = `/vm/${vmid}`;
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to renew ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#create-vm").click(function(){
    const name = document.getElementById('name').value;
    const cores = document.getElementById('cores').value;
    const mem = document.getElementById('mem').value;
    const template = document.getElementById('template').value;
    const iso = document.getElementById('iso').value;
    const user = document.getElementById('user');
    const max_disk = $(this).data('max_disk');
    var disk = document.getElementById('disk').value;
    fetch(`/template/${template}/disk`, {
        credentials: 'same-origin',
    }).then((response) => {
        return response.text()
    }).then((template_disk) => {
        if (template != 'none') {
            disk = template_disk
        }
        return disk
    }).then((disk) => {
        if (name && disk) {
            if (disk > max_disk) {
                swal("Uh oh...", `You do not have enough disk resources available! Please lower the VM disk size to ${max_disk}GB or lower.`, "error");
            } else {
                fetch(`/hostname/${name}`, {
                    credentials: 'same-origin',
                }).then((response) => {
                    return response.text()
                }).then((text) => {
                    if (text == 'ok') {
                        var loader = document.createElement('div');
                        loader.setAttribute('class', 'loader');
                        var info = document.createElement('span');
                        if (template == 'none') {
                            info.innerHTML = `Cores: ${cores}<br>Memory: ${mem/1024}GB<br>Disk: ${disk}GB<br>ISO: ${iso}`;
                        } else {
                            const template_select = document.getElementById('template');
                            const template_name = template_select.options[template_select.selectedIndex].text;
                            info.innerHTML = `Cores: ${cores}<br>Memory: ${mem/1024}GB<br>Template: ${template_name}`;
                        }
                        swal({
                            title: `Are you sure you want to create ${name}?`,
                            content: info,
                            icon: "info",
                            buttons: {
                                cancel: true,
                                create: {
                                    text: "Create",
                                    closeModal: false,
                                    className: "swal-button",
                                }
                            }
                        })
                        .then((willCreate) => {
                            if (willCreate) {
                                var data  = new FormData();
                                data.append('name', name);
                                data.append('cores', cores);
                                data.append('mem', mem);
                                data.append('template', template);
                                data.append('disk', disk);
                                data.append('iso', iso);
                                if (user) {
                                    data.append('user', user.value);
                                }
                                fetch('/vm/create', {
                                    credentials: 'same-origin',
                                    method: 'post',
                                    body: data
                                }).then((response) => {
                                    return response.text()
                                }).then((password) => {
                                    if (template == 'none') {
                                        var swal_text = `${name} is now being created. Check back soon and it should be good to go.`
                                    } else {
                                        var swal_text = `${name} is now being created. Check back soon and it should be good to go. The SSH credentials are your CSH username for the user and ${password} for the password. Save this password because you will not be able to retrieve it again!`
                                    }
                                    return swal(`${swal_text}`, {
                                        icon: "success",
                                        buttons: {
                                            ok: {
                                                text: "OK",
                                                closeModal: true,
                                                className: "",
                                            }
                                        }
                                    });
                                }).then(() => {
                                    window.location = "/";
                                });
                            }
                        });
                    } else if (text == 'invalid') {
                        swal("Uh oh...", `That name is not a valid name! Please try another name.`, "error");
                    } else if (text == 'taken') {
                        swal("Uh oh...", `That name is not available! Please try another name.`, "error");
                    }
                }).catch(err => {
                    if (err) {
                        swal("Uh oh...", `Unable to verify name! Please try again later.`, "error");
                    } else {
                        swal.stopLoading();
                        swal.close();
                    }
                });
            }
        } else if (!name && !disk) {
            swal("Uh oh...", `You must enter a name and disk size for your VM!`, "error");
        } else if (!name) {
            swal("Uh oh...", `You must enter a name for your VM!`, "error");
        } else if (!disk) {
            swal("Uh oh...", `You must enter a disk size for your VM!`, "error");
        }
    });
});

$("#change-cores").click(function(){
    const vmid = $(this).data('vmid');
    const cur_cores = $(this).data('cores');
    const usage = $(this).data('usage');
    const limit = $(this).data('limit');
    var core_list = document.createElement('select');
    core_list.setAttribute('style', 'width: 25px');
    for (i = 1; i < limit - usage + 1; i++) {
        core_list.appendChild(new Option(i, i));
    }
    swal({
        title: 'Select how many cores you would like to allocate to this VM:',
        content: core_list,
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            select: {
                text: "Select",
                closeModal: false,
                className: "swal-button",
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            const cores = $(core_list).val();
            fetch(`/vm/${vmid}/cpu/${cores}`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`Now applying the change to the number of cores!`, {
                    icon: "success",
                    buttons: {
                        ok: {
                            text: "OK",
                            closeModal: true,
                            className: "",
                        }
                    }
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            });
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to change the number of cores. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#change-mem").click(function(){
    const vmid = $(this).data('vmid');
    const cur_mem = $(this).data('mem');
    const usage = $(this).data('usage');
    const limit = $(this).data('limit');
    var mem_list = document.createElement('select');
    mem_list.setAttribute('style', 'width: 45px');
    for (i = 1; i < limit - usage + 1; i++) {
        mem_list.appendChild(new Option(`${i}GB`, i));
    }
    swal({
        title: 'Select how much memory you would like to allocate to this VM:',
        content: mem_list,
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            select: {
                text: "Select",
                closeModal: false,
                className: "swal-button",
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            const mem = $(mem_list).val();
            fetch(`/vm/${vmid}/mem/${mem}`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`Now applying the change to the amount of memory!`, {
                    icon: "success",
                    buttons: {
                        ok: {
                            text: "OK",
                            closeModal: true,
                            className: "",
                        }
                    }
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            });
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to change the amount of memory. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$(".edit-limit").click(function(){
    const user = $(this).data('user');
    const cur_cpu = $(this).data('cpu');
    const cur_mem = $(this).data('mem');
    const cur_disk = $(this).data('disk');
    var options = document.createElement('div');
    cpu_text = document.createElement('p');
    cpu_text.innerHTML = 'CPU';
    options.append(cpu_text);
    var cpu = document.createElement('input');
    cpu.type = 'number';
    cpu.defaultValue = cur_cpu;
    options.append(cpu);
    mem_text = document.createElement('p');
    mem_text.innerHTML = 'Memory (GB)';
    options.append(mem_text);
    var mem = document.createElement('input');
    mem.type = 'number';
    mem.defaultValue = cur_mem;
    options.append(mem)
    disk_text = document.createElement('p');
    disk_text.innerHTML = 'Disk (GB)';
    options.append(disk_text);
    var disk = document.createElement('input');
    disk.type = 'number';
    disk.defaultValue = cur_disk;
    options.append(disk)
    swal({
        title: `Enter the new usage limits for ${user}:`,
        content: options,
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            select: {
                text: "Submit",
                closeModal: false,
                className: "swal-button",
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            var data  = new FormData();
            data.append('cpu', $(cpu).val());
            data.append('mem', $(mem).val());
            data.append('disk', $(disk).val());
            fetch(`/limits/${user}`, {
                credentials: 'same-origin',
                method: 'post',
                body: data
            }).then((response) => {
                return swal(`Now applying the new limits to ${user}!`, {
                    icon: "success",
                    buttons: {
                        ok: {
                            text: "OK",
                            closeModal: true,
                            className: "",
                        }
                    }
                });
            }).then(() => {
                window.location = "/";
            });
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to change the limits for ${user}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$(".reset-limit").click(function(){
    const user = $(this).data('user');
    swal({
        title: `Are you sure you want to reset the usage limits for ${user} to the defaults?`,
        icon: "warning",
        buttons: {
            cancel: true,
            reset: {
                text: "reset",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willReset) => {
        if (willReset) {
            fetch(`/limits/${user}/reset`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`Usage limits for ${user} are now reset to defaults!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = "/";
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to reset the usage limits for ${user}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$(".delete-user").click(function(){
    const user = $(this).data('user');
    swal({
        title: `Are you sure you want to delete the pool for ${user}?`,
        icon: "warning",
        buttons: {
            cancel: true,
            delete: {
                text: "delete",
                closeModal: false,
                className: "swal-button--danger",
            }
        },
        dangerMode: true,
    })
    .then((willDelete) => {
        if (willDelete) {
            fetch(`/user/${user}/delete`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`The pool for ${user} has been deleted!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = "/";
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to delete the pool for ${user}. Please try again later.`, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
});

$(".delete-ignored-pool").click(function(){
    const pool = $(this).data('pool');
    fetch(`/pool/${pool}/ignore`, {
        credentials: 'same-origin',
        method: 'delete'
    });
    location.reload();
});

$(".add-ignored-pool").click(function(){
    const pool = document.getElementById('pool').value;
    fetch(`/pool/${pool}/ignore`, {
        credentials: 'same-origin',
        method: 'post'
    });
    location.reload();
});

function hide_for_template(obj) {
    var template_element = obj;
    var selected = template_element.options[template_element.selectedIndex].value;
    var hide_area = document.getElementById('hide-for-template');

    if(selected === 'none'){
        hide_area.style.display = 'block';
    }
    else{
        hide_area.style.display = 'none';
    }
}

$("#console-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid');
    fetch(`/vm/${vmid}/console`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
        return response.text()
    }).then((token) => {
        window.location = `/static/noVNC/vnc.html?autoconnect=true&?encrypt=true&?host=proxstar-vnc.csh.rit.edu&?port=443&?path=path?token=${token}`;
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to start console for ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});
