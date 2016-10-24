import React, {Component} from 'react';
import axios from 'axios';
import Dropzone from 'react-dropzone';

export default class AppComponent extends Component {
  
  render() {
    return (
      <div className="index">
        <Dropzone onDrop={this.onDrop.bind(this)}>
          <div>Try dropping some files here, or click to select files to upload.</div>
        </Dropzone>
      </div>
    );
  }
  
  onDrop(acceptedFiles){
    acceptedFiles.forEach( file => this.uploadToServer(file) );    
  }
  
  uploadToServer(file){
    var data = new FormData();
    data.append('file', file);
    axios.post('/upload', data )
      .then( response => window.console.log( 'Response from server: ', response ) )
      .catch( error => window.console.log( error ) );            
  }
  
}
