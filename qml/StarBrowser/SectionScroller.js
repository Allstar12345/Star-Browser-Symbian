.pragma library
// List of sectionscroller lists in application. Contains their
// sections and their sectiondata.
var _listViewList = [];
// Initialize and save the sections and sectiondata variables for the
// list.
function initSectionData(list) {
if (!list || !list.model) return;
if(!_listViewList[list])
_listViewList[list] = new Object();
_listViewList[list].sectionData = [];
_listViewList[list].sections = [];
var current = "";
var prop = list.section.property;
for (var i = 0, count = (typeof list.model.count === 'undefined' ? list.model.length : list.model.count); i < count; i++) {
var item = list.model.get(i);
if (item[prop] !== current) {
current = item[prop];
_listViewList[list].sections.push(current);
_listViewList[list].sectionData.push({ index: i, header: current });
}
}
}
function closestSection(list, pos) {
var sections = _listViewList[list].sections
var tmp = (sections.length) * pos;
var val = Math.ceil(tmp) // TODO: better algorithm
val = val < 2 ? 1 : val;
return sections[val-1];
}
function indexOf(list, sectionName) {
var sectionData = _listViewList[list].sectionData
var sections = _listViewList[list].sections
var val = sectionData[sections.indexOf(sectionName)].index;
return val === 0 || val > 0 ? val : -1;
}
function removeSectionData(list) {
delete _listViewList[list];
}
