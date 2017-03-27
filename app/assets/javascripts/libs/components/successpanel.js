import React from 'react';

export default class SuccessPanel extends React.Component {
  hide(){
    this.props.onHidePanel();
  }

  componentDidMount(){
    var self=this;
    var domNode=ReactDOM.findDOMNode(this);

    window.setTimeout(function () {
      $(domNode).fadeOut(1000,function(){self.hide()});
    }, 3000);
  }
  
  render(){
    return (
      <div className="alert alert-success" role="alert">
        <button type="button" className="close" aria-label="Close" onClick={this.hide}><span aria-hidden="true">&times;</span></button>
        <span className="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <span className="sr-only">Info:</span>
        &nbsp;{this.props.message}
      </div>
    );
  }
};