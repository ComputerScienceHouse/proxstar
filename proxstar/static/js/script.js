/*jshint esversion: 6 */

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});

function confirmDialog(url, confirm, confirmButton, complete, error, location, danger) {
    swal({
        title: confirm,
        icon: "warning",
        buttons: {
            cancel: true,
            action: {
                text: confirmButton,
                closeModal: false,
                className: danger ? "swal-button--danger" : "swal-button--confirm",
            }
        },
        dangerMode: true,
    })
    .then((willComplete) => {
        if (willComplete) {
            fetch(url, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(complete, {
                    icon: "success",
                });
            }).then(() => {
                window.location = location;
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", error, "error");
                } else {
                    swal.stopLoading();
                    swal.close();
                }
            });
        }
    });
}

$("#delete-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/delete`, `Are you sure you want to delete ${vmname}?`, "Delete", `${vmname} is now being deleted.`, `Unable to delete ${vmname}. Please try again later.`, '/', true)
});

$("#stop-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/power/stop`, `Are you sure you want to stop ${vmname}?`, "Stop", `${vmname} is now stopping!`, `Unable to stop ${vmname}. Please try again later.`, `/vm/${vmid}`, true)
});

$("#reset-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/power/reset`, `Are you sure you want to reset ${vmname}?`, "Reset", `${vmname} is now resetting!`, `Unable to reset ${vmname}. Please try again later.`, `/vm/${vmid}`, true)
});

$("#shutdown-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/power/shutdown`, `Are you sure you want to shutdown ${vmname}?`, "Shutdown", `${vmname} is now shutting down!`, `Unable to shutdown ${vmname}. Please try again later.`, `/vm/${vmid}`, true)
});

$("#suspend-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/power/suspend`, `Are you sure you want to suspend ${vmname}?`, "Suspend", `${vmname} is now suspending!`, `Unable to suspend ${vmname}. Please try again later.`, `/vm/${vmid}`, true)
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

$(".eject-iso").click(function(){
    const iso = $(this).data('iso');
    const vmid = $(this).data('vmid');
    confirmDialog(`/vm/${vmid}/iso/${iso}/eject`, `Are you sure you want to eject this ISO?`, "Eject", `Ejecting ISO!`, `Unable to eject ISO. Please try again later.`, `/vm/${vmid}`, true)
});


$(".change-iso").click(function(){
    fetch(`/isos`, {
        credentials: 'same-origin',
    }).then((response) => {
        return response.json()
    }).then((json) => {
        var iso_list = document.createElement('select');
        for (i = 0; i < json.isos.length; i++) {
            iso_list.appendChild(new Option(json.isos[i], json.isos[i]));
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
                confirm: {
                    text: "Select",
                    closeModal: false,
                    className: "",
                }
            },
        })
        .then((willChange) => {
            if (willChange) {
                const vmid = $(this).data('vmid');
                const iso_drive = $(this).data('iso');
                const iso = $(iso_list).val();
                fetch(`/vm/${vmid}/iso/${iso_drive}/mount/${iso}`, {
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
    const name = document.getElementById('name').value.toLowerCase();
    const cores = document.getElementById('cores').value;
    const mem = document.getElementById('mem').value;
    const template = document.getElementById('template').value;
    const ssh_key = document.getElementById('ssh-key').value;
    const iso = document.getElementById('iso').value;
    const user = document.getElementById('user');
    const max_cpu = $(this).data('max_cpu');
    const max_mem = $(this).data('max_mem');
    const max_disk = $(this).data('max_disk');
    var ssh_regex = new RegExp("ssh-rsa AAAA[0-9A-Za-z+/]+[=]{0,3}( [^@]+@[^@]+)?")
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
            if (template != 'none' && !ssh_regex.test(ssh_key)) {
                swal("Uh oh...", "Invalid SSH key!", "error");
            // MAXIMUM BOUNDS CHECK
            } else if (disk > max_disk) {
                swal("Uh oh...", `You do not have enough disk resources available! Please lower the VM disk size to ${max_disk}GB or lower.`, "error");
            } else if (template != 'none' && cores > max_cpu) {
                swal("Uh oh...", `You do not have enough CPU resources available! Please lower the VM cores to ${max_cpu} or lower.`, "error");
            } else if (template != 'none' && mem/1024 > max_mem) {
                swal("Uh oh...", `You do not have enough memory resources available! Please lower the VM memory to ${max_mem}GB or lower.`, "error");
            // MINIMUM BOUNDS CHECK
            else if(0 <= disk){
              swal("Uh oh...", `Selected disk size is less than 0.`,"error");
            }else if(0 <= cores){
              swal("Uh oh...", `Selected cores amount is less than 0.`,"error");
            }else if(0 <= mem){
              swal("Uh oh...", `Selected memory size is less than 0.`,"error");
            }
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
                                confirm: {
                                    text: "Create",
                                    closeModal: false,
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
                                data.append('ssh_key', ssh_key);
                                if (user) {
                                    data.append('user', user.value);
                                }
                                fetch('/vm/create', {
                                    credentials: 'same-origin',
                                    method: 'post',
                                    body: data
                                }).then((response) => {
                                    if (template == 'none') {
                                        var swal_text = `${name} is now being created. Check back soon and it should be good to go.`
                                    } else {
                                        var swal_text = `${name} is now being created. Check back soon and it should be good to go. The SSH credentials are your CSH username for the user and the SSH key you provided.`
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

$("#create-pool").click(function(){
    console.log("bingus");
    const name = document.getElementById('name').value.toLowerCase();
    const description = document.getElementById('description').value;
    const members = document.getElementById('members').value;
    var info = document.createElement('span');
    swal({
        title: `Are you sure you want to create ${name}?`,
        content: info,
        icon: "info",
        buttons: {
            cancel: true,
            confirm: {
                text: "Create",
                closeModal: false,
            }
        }
    })
    .then((willCreate) => {
        if (willCreate) {
            var data  = new FormData();
            data.append('name', name);
            data.append('description', description);
            data.append('members', members);
            fetch('/pool/shared/create', {
                credentials: 'same-origin',
                method: 'POST',
                body: data
            }).then((response) => {
                console.log(response);
                var swal_text = `${name} is now being created. Check back soon and it should be good to go.`
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
});

$("#change-cores").click(function(){
    const vmid = $(this).data('vmid');
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
            confirm: {
                text: "Select",
                closeModal: false,
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
            confirm: {
                text: "Select",
                closeModal: false,
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
            confirm: {
                text: "Submit",
                closeModal: false,
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

$(".edit-shared-members").click(function(){
    const pool = $(this).data('pool');
    const currentMembers = $(this).data('members').slice(1,-1).split(', ');
    var currentMembersString = "";
    currentMembers.forEach(name => {
        currentMembersString += name.slice(1,-1) + ',';
    });
    var options = document.createElement('div');
    var members = document.createElement('input');
    members.type = 'text';
    members.defaultValue = currentMembersString.slice(0,-1);
    options.append(members);
    swal({
        title: `Enter the new member list for ${pool}:`,
        content: options,
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            confirm: {
                text: "Submit",
                closeModal: false,
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            var data  = new FormData();
            data.append('members', $(members).val());
            fetch(`/pool/shared/${pool}/modify`, {
                credentials: 'same-origin',
                method: 'post',
                body: data
            }).then((response) => {
                return swal(`Now applying new member list to ${pool}!`, {
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
            swal("Uh oh...", `Unable to change the members of ${pool}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
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

$(".delete-pool").click(function(){
    const pool = $(this).data('pool');
    swal({
        title: `Are you sure you want to delete the pool ${pool}?`,
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
            fetch(`/pool/shared/${ pool }/delete`, {
                credentials: 'same-origin',
                method: 'post'
            }).then((response) => {
                return swal(`The pool ${pool} has been deleted!`, {
                    icon: "success",
                });
            }).then(() => {
                window.location = "/";
            }).catch(err => {
                if (err) {
                    swal("Uh oh...", `Unable to delete the pool ${pool}. Please try again later.`, "error");
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
    }).then((response) => {
    location.reload();
    });
});

$(".add-ignored-pool").click(function(){
    const pool = document.getElementById('pool').value;
    fetch(`/pool/${pool}/ignore`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
    location.reload();
    });
});

function change_for_template(obj) {
    var template_element = obj;
    var selected = template_element.options[template_element.selectedIndex].value;
    var hide_area = document.getElementById('hide-for-template');
    var show_area = document.getElementById('show-for-template');

    if (selected === 'none') {
        hide_area.style.display = 'block';
        show_area.style.display = 'none';
    }
    else {
        hide_area.style.display = 'none';
        show_area.style.display = 'block';
    }
}

$("#console-vm").click(function(){
    const vmname = $(this).data('vmname');
    const vmid = $(this).data('vmid');
    fetch(`/console/vm/${vmid}`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
        return response.json()
    }).then((vnc_params) => {
        // TODO (willnilges): encrypt=true
        // TODO (willnilges): set host and port to an env variable
        window.open(`/static/noVNC/vnc.html?autoconnect=true&password=${vnc_params.password}&host=${vnc_params.host}&port=${vnc_params.port}&path=path?token=${vnc_params.token}`, '_blank');
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to start console for ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$(".delete-allowed-user").click(function(){
    const user = $(this).data('user');
    fetch(`/user/${user}/allow`, {
        credentials: 'same-origin',
        method: 'delete'
    }).then((response) => {
    location.reload();
    });
});

$(".add-allowed-user").click(function(){
    const user = document.getElementById('user').value;
    fetch(`/user/${user}/allow`, {
        credentials: 'same-origin',
        method: 'post'
    }).then((response) => {
    location.reload();
    });
});

$(".resize-disk").click(function(){
    const vmid = $(this).data('vmid');
    const disk = $(this).data('disk');
    const usage = $(this).data('usage');
    const limit = $(this).data('limit');
    swal({
        title: 'Expand Disk',
        text: 'Enter how many GB you would like to expand this disk by (GB)',
        content: {
            element: 'input',
            attributes: {
                type: 'number',
            },
        },
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            confirm: {
                text: "Expand",
                closeModal: false,
            }
        },
    })
    .then((size) => {
        if (size) {
            if ((parseInt(usage) + parseInt(size)) <= parseInt(limit)) {
                fetch(`/vm/${vmid}/disk/${disk}/resize/${size}`, {
                    credentials: 'same-origin',
                    method: 'post'
                }).then((response) => {
                    return swal(`Disk size has been increased!`, {
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
            } else {
                swal("Uh oh...", `You don't have enough disk resources! Try again with a smaller size.`, "error");
            }
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to resize the disk. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$(".edit-template").click(function(){
    const template_id = $(this).data('template_id');
    const template_name = $(this).data('template_name');
    const template_disk = $(this).data('template_disk');
    var options = document.createElement('div');
    name_text = document.createElement('p');
    name_text.innerHTML = 'Name';
    options.append(name_text);
    var name = document.createElement('input');
    name.defaultValue = template_name;
    options.append(name);
    disk_text = document.createElement('p');
    disk_text.innerHTML = 'Disk Size (GB)';
    options.append(disk_text);
    var disk = document.createElement('input');
    disk.type = 'number';
    disk.defaultValue = template_disk;
    options.append(disk);
    swal({
        title: `Template ${template_id}:`,
        content: options,
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            confirm: {
                text: "Submit",
                closeModal: false,
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            var data  = new FormData();
            data.append('name', $(name).val());
            data.append('disk', $(disk).val());
            fetch(`/template/${template_id}/edit`, {
                credentials: 'same-origin',
                method: 'post',
                body: data
            }).then((response) => {
                return swal(`Template info changed!`, {
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
                location.reload();
            });
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to change the template info. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$("#edit-boot-order").click(function(){
    const vmid = $(this).data('vmid');
    const vmname = $(this).data('vmname');
    const boot_order = $(this).data('boot_order');
    var options = renderBootOrder(boot_order);
    swal({
        title: `Select the new boot order for ${vmname} (full shutdown required for settings to take effect):`,
        content: renderBootOrder(boot_order),
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
            },
            confirm: {
                text: "Submit",
                closeModal: false,
            }
        },
    })
    .then((willChange) => {
        if (willChange) {
            var data  = new FormData();
            if (boot_order.legacy) {
                for (k = 0; k < boot_order.order.length; k++) {
                    e = document.getElementById(`boot-order-${k + 1}`);
                    data.append(`${k + 1}`, e.options[e.selectedIndex].value);
                }
            }
            else {
                document.getElementById('boot-order-sortable').childNodes.forEach((order, index) => {
                    if (order.children[1].firstChild.checked) {
                        data.append(`${index + 1}`, order.children[2].innerHTML);
                    }
                });
            }
            fetch(`/vm/${vmid}/boot_order`, {
                credentials: 'same-origin',
                method: 'post',
                body: data
            }).then((response) => {
                return swal(`Now applying the new boot order to ${vmname}!`, {
                    icon: "success",
                    buttons: {
                        ok: {
                            text: "OK",
                            closeModal: true,
                        }
                    }
                });
            }).then(() => {
                window.location = `/vm/${vmid}`;
            });
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to change the boot order for ${vmname}. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

function renderBootOrder(boot_order) {
    let options = document.createElement('div');
    if (boot_order.legacy) {
        for (i = 0; i < boot_order.order.length; i++) {
            text = document.createElement('span');
            text.innerHTML = `${i + 1}. `;
            options.append(text);
            var entry = document.createElement('select');
            entry.setAttribute("id", `boot-order-${i + 1}`);
            for (j = 0; j < boot_order.order.length; j++) {
                entry.appendChild(new Option(boot_order.order[j].device, boot_order.order[j].device));
            }
            entry.selectedIndex = i;
            entry.setAttribute('style', 'width: 85px');
            options.append(entry);
            options.append(document.createElement('br'));
        }
    }
    else {
        let table = document.createElement('table');
        table.classList.add('table', 'table-sm', 'borderless', 'text-left');
        let thead = table.createTHead();
        thead.classList.add('font-weight-bold');
        let tbody = table.createTBody();
        tbody.classList.add('text-break', 'boot-order-sortable');
        tbody.id = 'boot-order-sortable';
        let hrow = thead.insertRow();
        hrow.insertCell().innerHTML = 'Order';
        hrow.insertCell().innerHTML = 'Enabled';
        hrow.insertCell().innerHTML = 'Device';
        hrow.insertCell().innerHTML = 'Description';
        for (i = 0; i < boot_order.order.length; i++) {
            let row = tbody.insertRow();
            row.id = `boot-order-${i + 1}`;
            $(row.insertCell()).append(
                $('<i>', {
                    class: 'fas fa-bars'
                }),
                $('<span>', {
                    class: 'boot-order-number',
                    id: `boot-order-number-${i + 1}`,
                    style: 'margin-left: .25rem',
                    text: `${i + 1}`
                })
            );
            let checkCell = $(row.insertCell()).addClass('text-center');
            $(checkCell).append(
                $('<input>', {
                    type: 'checkbox',
                    class: 'form-check-input boot-order-check',
                    checked: boot_order.order[i].enabled
                })
            );
            row.insertCell().innerHTML = boot_order.order[i].device;
            row.insertCell().innerHTML = boot_order.order[i].description;
        }
        new Sortable(tbody, {
            animation: 150,
            filter: '.boot-order-check',
            onEnd: function(event) {
                numberBootOrderTable();
            },
        });
        options.append(table);
    }
    return options;
}

function numberBootOrderTable() {
    let i = 0;
    $('[id^=boot-order-number]').each(function() {
        this.innerHTML = ++i;
    })
}

$(document).on('focus click', "[id^=boot-order-]", function() {
    previous = $(this).val();
}).on('change', "[id^=boot-order-]", function() {
    current = $(this).val();
    id = $(this).attr("id");
    $("[id^=boot-order-]").each(function() {
        if ($(this).attr("id") != id && $(this).val() == current) {
            $(this).val(previous);
        }
    });
});

$("#create-net").click(function(){
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/net/create`, `Are you sure you want to create a new interface?`, "Create", `Creating new interface!`, `Unable to create interface. Please try again later.`, `/vm/${vmid}`, false)
});

$(".delete-net").click(function(){
    const vmid = $(this).data('vmid')
    const interface = $(this).data('interface')
    confirmDialog(`/vm/${vmid}/net/${interface}/delete`, `Are you sure you want to delete ${interface}?`, "Delete", `Deleting ${interface}!`, `Unable to delete interface. Please try again later.`, `/vm/${vmid}`, true)
});

$("#create-iso").click(function(){
    const vmid = $(this).data('vmid')
    confirmDialog(`/vm/${vmid}/iso/create`, `Are you sure you want to create a new ISO drive?`, "Create", `Creating new ISO drive!`, `Unable to create ISO drive. Please try again later.`, `/vm/${vmid}`, false)
});

$(".delete-iso").click(function(){
    const vmid = $(this).data('vmid')
    const iso = $(this).data('iso')
    confirmDialog(`/vm/${vmid}/iso/${iso}/delete`, `Are you sure you want to delete ${iso}?`, "Delete", `Deleting ${iso}!`, `Unable to delete ISO drive. Please try again later.`, `/vm/${vmid}`, true)
});

$("#create-disk").click(function(){
    const vmid = $(this).data('vmid');
    const disk = $(this).data('disk');
    const usage = $(this).data('usage');
    const limit = $(this).data('limit');
    swal({
        title: 'Create New Disk',
        text: 'Enter new disk size (GB)',
        content: {
            element: 'input',
            attributes: {
                type: 'number',
            },
        },
        buttons: {
            cancel: {
                text: "Cancel",
                visible: true,
                closeModal: true,
                className: "",
            },
            confirm: {
                text: "Create",
                closeModal: false,
            }
        },
    })
    .then((size) => {
        if (size) {
            if ((parseInt(usage) + parseInt(size)) <= parseInt(limit)) {
                fetch(`/vm/${vmid}/disk/create/${size}`, {
                    credentials: 'same-origin',
                    method: 'post'
                }).then((response) => {
                    return swal(`Disk has been created!`, {
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
            } else {
                swal("Uh oh...", `You don't have enough disk resources! Try again with a smaller size.`, "error");
            }
        }
    }).catch(err => {
        if (err) {
            swal("Uh oh...", `Unable to create the disk. Please try again later.`, "error");
        } else {
            swal.stopLoading();
            swal.close();
        }
    });
});

$(".delete-disk").click(function(){
    const vmid = $(this).data('vmid')
    const disk = $(this).data('disk')
    confirmDialog(`/vm/${vmid}/disk/${disk}/delete`, `Are you sure you want to delete ${disk}?`, "Delete", `Deleting ${disk}!`, `Unable to delete disk. Please try again later.`, `/vm/${vmid}`, true)
});
