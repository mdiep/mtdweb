
Dialog.EditTags = Class.create(Dialog.Box, {
    initialize: function($super, url) {
        this.save_url = url;
        $super('edit-tags-dialog');
    },

    hide: function($super) {
        var selected = edit_tags_list.getElementsBySelector('.selected-tag a');
        var params   = { };
        for (var i=0, tag; tag = selected[i]; i++)
            params['tags[' + i + ']'] = tag.text;

        new Ajax.Updater({ success: 'contact-tag-list' }, this.save_url, {
            parameters: params,
        });
        $super();
    },
});

function createTagDiv(tagName)
{
    var id       = 'edit-tag-' + tagName;
    var tag_link = new Element('a', { href: 'javascript:toggleTag("' + id + '")' }).update(tagName);
    var tag_div  = new Element('div', { 'class': 'tag', 'id': id }).update(tag_link);
    return tag_div;
}

for (var i = 0, tag; tag = tags[i]; i++)
{           
    edit_tags_list.insert(createTagDiv(tag));
}
for (var i = 0, tag; tag = selected_tags[i]; i++)
{
    toggleTag('edit-tag-' + tag);
}

function addTag()
{
    var tagName = $F($('tag_name'));
    $('tag_name').clear();
    if (tags.include(tagName))
        return false;
    
    tags.push(tagName);
    tags.sort();

    var tag_div = createTagDiv(tagName);
    
    var i = tags.indexOf(tagName);
    if (i == tags.length - 1)
        edit_tags_list.insert(tag_div)
    else
    {
        var next_tag = 'edit-tag-' + tags[i+1];
        $(next_tag).insert({ before: tag_div });
    }
    toggleTag(tag_div);

    return false;
}

function toggleTag(tag)
{
    tag = $(tag);

    if (tag.hasClassName('selected-tag'))
        tag.removeClassName('selected-tag');
    else
        tag.addClassName('selected-tag');
}

