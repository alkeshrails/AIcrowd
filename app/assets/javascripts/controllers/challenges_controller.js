Paloma.controller('Challenges', {
    reorder: function () {
        let calculateIndex = function () {
            let landingPageIdx = 6;
            let l = $(".challenge-list-row .new-seq");
            for (let i = 0; i < l.length; i++) {
                l[i].innerText = i.toString();
                let current = $(l[i].parentNode);
                // Hidden and Private challenges have a badge!
                let hasBadge = current.has('.badge').length > 0;
                let draftChallenge = current.children()[1].textContent === "draft";
                if (i < landingPageIdx) {
                    if (hasBadge || draftChallenge) {
                        landingPageIdx++;
                        continue;
                    }
                    $(current).addClass('table-success');
                } else {
                    $(current).removeClass('table-success');
                }
            }
        };
        $(function () {
            let selected_sortable = $("#sortable");
            calculateIndex();
            selected_sortable.sortable({
                update: function (event, ui) {
                    calculateIndex();
                    let order = $("#sortable").sortable("toArray");
                    order[0] && $('#order').val(order.join(","));
                }
            });
            selected_sortable.disableSelection();
            let order = selected_sortable.sortable("toArray");
            order[0] && $('#order').val(order.join(","));
        });
    },
    edit: function () {
        $('.active-switch').click(function () {
            let self = this;
            $('.active-switch').each(function () {
                this.checked = false;
            });
            self.checked = true;
        });
        $('#replace-rules-button').click(function (e) {
            $(this).hide()
        })
    },
    show: function () {
        document.querySelectorAll( 'oembed[url]' ).forEach( element => {
            // Create the <a href="..." class="embedly-card"></a> element that Embedly uses
            // to discover the media.
            const anchor = document.createElement( 'a' );

            anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
            anchor.className = 'embedly-card';

            element.appendChild( anchor );
        } );

        let update_table_of_contents = function (headings) {
            let toc = $("#table-of-contents");
            $.each(headings, (idx, heading) => {
                // Jqeury Object from DOM object
                heading = $(heading);
                let heading_content = heading.text();
                heading.attr('id', heading_content);

                let li = $('<li/>', {
                    "class": 'nav-link',
                }).appendTo(toc);

                $('<a/>', {
                    "class": 'nav-item',
                    href: "#"+heading_content,
                    text: _.capitalize(heading_content)
                }).appendTo(li);

                console.log(toc);
                // Attach ScrollSpy only after the TOC has been generated.
                if (idx === headings.length) {
                    console.log("Generated!");
                    $('body').scrollspy({target: "#table-of-contents", offset: 64});
                }
            });
        };
        // NATE: Apparently challenges#show is not using turbolinks
        $(document).ready(function () {
            let headings = $("#description-wrapper h2").get();
            update_table_of_contents(headings);
        });
    }
});
