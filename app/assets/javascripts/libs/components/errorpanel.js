import React from 'react';

export default class ErrorPanel extends React.Component {
  render(){
    return (
      <div className="alert alert-danger" role="alert">
        <span className="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span className="sr-only">Error:</span>
        &nbsp;{this.props.message}
      </div>
    );
  }
};
